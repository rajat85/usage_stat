class PageVisit < Sequel::Model
  def before_save
    self.hash = Digest::MD5.hexdigest({
      id: id,
      url: url,
      referrer: referrer,
      created_at: created_at
    }.to_s)
    super
  end

  def self.top_urls
    query = <<-SQL
      SELECT
        to_char(created_at, 'YYYY-MM-DD') as date,
        url,
        count(id) as visits
      FROM page_visits
      WHERE created_at >= :from_date AND created_at <= :to_date
      GROUP BY 1, 2
      ORDER BY 1 DESC, 3 DESC;
    SQL

    results = with_sql(query, from_date: 5.days.ago, to_date: Time.current).all

    results.group_by do |result|
      result.values[:date]
    end
  end

  def self.top_referrers
    query = <<-SQL
      SELECT
        top_urls.date,
        top_urls.url,
        top_urls.rank as url_rank,
        top_urls.visits as url_visit,
        top_referrers.referrer,
        top_referrers.rank as referrer_rank,
        top_referrers.visits as referrer_visits
      FROM
        (
          SELECT
            date,
            url,
            referrer,
            rank,
            visits
          FROM
            (
              SELECT
                to_char(created_at, 'YYYY-MM-DD') as date,
                url,
                referrer,
                COUNT(id) as visits,
                rank() OVER (PARTITION BY to_char(created_at, 'YYYY-MM-DD'), url ORDER BY COUNT(id) DESC) as rank
              FROM page_visits
              WHERE created_at >= :from_date AND created_at < :to_date
              GROUP BY 1, 2, 3
            ) as temp
          WHERE rank <= 5
      ) AS top_referrers,


      (
        SELECT
          date,
          url,
          visits,
          rank
          FROM
          (SELECT
          date,
          url,
          visits,
          dense_rank() OVER (PARTITION BY date ORDER BY visits DESC) as rank
        FROM
          (
            SELECT
              to_char(created_at, 'YYYY-MM-DD') as date,
              url,
              COUNT(id) as visits
            FROM page_visits
            WHERE created_at >= :from_date AND created_at < :to_date
            GROUP BY 1, 2
          ) AS temp1
        ) AS temp2
        WHERE rank <=10
      ) AS top_urls

      WHERE top_referrers.date = top_urls.date AND top_referrers.url = top_urls.url
      ORDER BY top_urls.date DESC, top_urls.rank ASC, top_referrers.rank ASC
    SQL

    results = with_sql(query, from_date: 5.days.ago, to_date: Time.current).all.map(&:values)
    results = results.group_by do |result|
      result[:date]
    end

    data = {}
    results.each do |key, values|
      arr = []
      values.each do |val|
        next if arr.any? { |a| a[:url] == val[:url] }
        h = { url: val[:url], visits: val[:url_visit] }
        h[:referrers] = values.select { |v| v[:url] == val[:url] }.collect do |r|
          { url: r[:referrer], visits: r[:referrer_visits] }
        end
        arr.push(h)
      end
      data[key] = arr
    end

    data
  end
end
