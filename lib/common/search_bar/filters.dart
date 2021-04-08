class SearchFilters {
  late List<SearchQuery> _queries;
  late List<SearchQuery> _sensitiveQueries;
  List<SearchQuery> _blackList = [];
  final SearchQueries searchQueries = SearchQueries();
  RegExp? _queriesRegExp;
  RegExp? _blacklistRegExp;
  RegExp? _sensitiveQueriesOptionsRegExp;
  RegExp? _sensitiveQueriesRegExp;

  RegExp get queriesRegExp => _queriesRegExp!;
  RegExp get blacklistRegExp => _blacklistRegExp!;
  RegExp get stringOptionQueriesRegExp => _sensitiveQueriesOptionsRegExp!;
  RegExp get sensitiveQueriesOptionsRegExp => _sensitiveQueriesRegExp!;
  List<SearchQuery> get queries => _queries;
  List<SearchQuery> get sensitiveQueries => _sensitiveQueries;
  List<SearchQuery> get whiteListedQueries => _sensitiveQueries + _queries;

  SearchQuery? queryFromString(String query) {
    SearchQuery? value;
    (_queries + _sensitiveQueries + _blackList).forEach((element) {
      if (element.query == query) value = element;
    });
    return value;
  }

  SearchFilters.repositories({List<String> blacklist = const []}) {
    _filterQueries([
      searchQueries.repo,
      searchQueries.user,
      searchQueries.org,
      searchQueries.size,
      searchQueries.followers,
      searchQueries.forks,
      searchQueries.created,
      searchQueries.pushed,
      searchQueries.language,
      searchQueries.topic,
      searchQueries.topics,
      searchQueries.license,
      searchQueries.iN
        ..options = {
          'name': 'Name',
          'description': 'Description',
          'readme': 'Readme'
        },
      searchQueries.iS,
      searchQueries.mirror,
      searchQueries.stars,
      searchQueries.archived,
      searchQueries.goodFirstIssues,
      searchQueries.helpWantedIssues,
    ], blacklist);
    _queriesRegExp = _getRegExp(_queries);
    _blacklistRegExp = _getRegExp(_blackList);
    _sensitiveQueriesRegExp = _getRegExp(_sensitiveQueries);
    _sensitiveQueriesOptionsRegExp =
        _getSensitiveQueryRegExp(_sensitiveQueries);
  }

  RegExp _getSensitiveQueryRegExp(List<SearchQuery> queries) {
    List<SearchQuery> stringQ = [];
    List<SearchQuery> dateQ = [];
    List<SearchQuery> numberQ = [];
    queries.forEach(
      (element) {
        if (element.type == QueryType.date)
          dateQ.add(element);
        else if (element.type == QueryType.number)
          numberQ.add(element);
        else
          stringQ.add(element);
      },
    );
    List<String> stringsQ = stringQ
        .map((query) => query.options!.keys
            .map((option) => '${query.query}:$option')
            .join('|'))
        .toList();
    String stringRegexp = '(?:-)?(?:${stringsQ.join('|')})';
    List<String> numbersQ = numberQ.map((query) => '${query.query}:').toList();
    String numberRegexp =
        '(?:-)?(?:${numbersQ.join('|')})([><][=]?)?([0-9]+)(?=(\\s)(${numbersQ.join('|')})?|\$)|(?:-)?(?:${numbersQ.join('|')})([0-9]+)([.][.][*])(?=(\\s)(${numbersQ.join('|')})?|\$)|(?:-)?(?:${numbersQ.join('|')})([*][.][.])([0-9]+)(?=(\\s)(${numbersQ.join('|')})?|\$)';

    return RegExp(stringRegexp + '|' + numberRegexp);
  }

  RegExp _getRegExp(List<SearchQuery> queries) {
    List<String> strings = queries.map((e) => e.query + ':').toList();
    String filter = strings.join('|');
    return RegExp(
        '(?:-)?(?:$filter)([=><]{1,2})?([*..]{1,3})?((\\w|\\d| |[a-zA-Z0-9!@#\$&()\\-`.+,/"])*)([..*]{1,3})?(?=(\\s)($filter)?|\$)');
  }

  void _filterQueries(List<SearchQuery> original, List<String> blacklist) {
    original.forEach(
      (element) {
        if (!blacklist.contains(element.query)) {
          if (element.type != QueryType.string || element.options != null)
            _sensitiveQueries.add(element);
          else
            _queries.add(element);
        } else
          _blackList.add(element);
      },
    );
  }
}

class SearchQueries {
  SearchQuery archived = SearchQuery(SearchQueryStrings.archived);
  SearchQuery assignee = SearchQuery(SearchQueryStrings.assignee);
  SearchQuery author = SearchQuery(SearchQueryStrings.author);
  SearchQuery authorName = SearchQuery(SearchQueryStrings.authorName);
  SearchQuery authorEmail = SearchQuery(SearchQueryStrings.authorEmail);
  SearchQuery authorDate = SearchQuery(SearchQueryStrings.authorDate);
  SearchQuery base = SearchQuery(SearchQueryStrings.base);
  SearchQuery closed = SearchQuery(SearchQueryStrings.closed);
  SearchQuery commenter = SearchQuery(SearchQueryStrings.commenter);
  SearchQuery comments = SearchQuery(SearchQueryStrings.comments);
  SearchQuery committer = SearchQuery(SearchQueryStrings.committer);
  SearchQuery committerName = SearchQuery(SearchQueryStrings.committerName);
  SearchQuery committerEmail = SearchQuery(SearchQueryStrings.committerEmail);
  SearchQuery committerDate = SearchQuery(SearchQueryStrings.committerDate);
  SearchQuery created =
      SearchQuery(SearchQueryStrings.created, type: QueryType.date);
  SearchQuery draft = SearchQuery(SearchQueryStrings.draft);
  SearchQuery extension = SearchQuery(SearchQueryStrings.extension);
  SearchQuery filename = SearchQuery(SearchQueryStrings.filename);
  SearchQuery followers =
      SearchQuery(SearchQueryStrings.followers, type: QueryType.number);
  SearchQuery fork = SearchQuery(SearchQueryStrings.fork);
  SearchQuery forks =
      SearchQuery(SearchQueryStrings.forks, type: QueryType.number);
  SearchQuery fullName = SearchQuery(SearchQueryStrings.fullName);
  SearchQuery goodFirstIssues = SearchQuery(SearchQueryStrings.goodFirstIssues);
  SearchQuery hash = SearchQuery(SearchQueryStrings.hash);
  SearchQuery head = SearchQuery(SearchQueryStrings.head);
  SearchQuery helpWantedIssues =
      SearchQuery(SearchQueryStrings.helpWantedIssues);
  SearchQuery iN = SearchQuery(SearchQueryStrings.iN);
  SearchQuery interactions = SearchQuery(SearchQueryStrings.interactions);
  SearchQuery involves = SearchQuery(SearchQueryStrings.involves);
  SearchQuery iS = SearchQuery(SearchQueryStrings.iS);
  SearchQuery label = SearchQuery(SearchQueryStrings.label);
  SearchQuery language = SearchQuery(SearchQueryStrings.language);
  SearchQuery license = SearchQuery(SearchQueryStrings.license);
  SearchQuery linked = SearchQuery(SearchQueryStrings.linked);
  SearchQuery location = SearchQuery(SearchQueryStrings.location);
  SearchQuery merge = SearchQuery(SearchQueryStrings.merge);
  SearchQuery merged = SearchQuery(SearchQueryStrings.merged);
  SearchQuery mentions = SearchQuery(SearchQueryStrings.mentions);
  SearchQuery milestone = SearchQuery(SearchQueryStrings.milestone);
  SearchQuery mirror = SearchQuery(SearchQueryStrings.mirror);
  SearchQuery no = SearchQuery(SearchQueryStrings.no);
  SearchQuery org = SearchQuery(SearchQueryStrings.org, type: QueryType.user);
  SearchQuery parent = SearchQuery(SearchQueryStrings.parent);
  SearchQuery path = SearchQuery(SearchQueryStrings.path);
  SearchQuery project = SearchQuery(SearchQueryStrings.project);
  SearchQuery pushed =
      SearchQuery(SearchQueryStrings.pushed, type: QueryType.date);
  SearchQuery reactions = SearchQuery(SearchQueryStrings.reactions);
  SearchQuery repo = SearchQuery(SearchQueryStrings.repo);
  SearchQuery repos = SearchQuery(SearchQueryStrings.repos);
  SearchQuery repositories = SearchQuery(SearchQueryStrings.repositories);
  SearchQuery review = SearchQuery(SearchQueryStrings.review);
  SearchQuery reviewedBy = SearchQuery(SearchQueryStrings.reviewedBy);
  SearchQuery reviewRequested = SearchQuery(SearchQueryStrings.reviewRequested);
  SearchQuery teamReviewRequested =
      SearchQuery(SearchQueryStrings.teamReviewRequested);
  SearchQuery sha = SearchQuery(SearchQueryStrings.sha);
  SearchQuery size =
      SearchQuery(SearchQueryStrings.size, type: QueryType.number);
  SearchQuery stars =
      SearchQuery(SearchQueryStrings.stars, type: QueryType.number);
  SearchQuery state = SearchQuery(SearchQueryStrings.state);
  SearchQuery status = SearchQuery(SearchQueryStrings.status);
  SearchQuery team = SearchQuery(SearchQueryStrings.team);
  SearchQuery topic = SearchQuery(SearchQueryStrings.topic);
  SearchQuery topics =
      SearchQuery(SearchQueryStrings.topics, type: QueryType.number);
  SearchQuery tree = SearchQuery(SearchQueryStrings.tree);
  SearchQuery type = SearchQuery(SearchQueryStrings.type);
  SearchQuery updated = SearchQuery(SearchQueryStrings.updated);
  SearchQuery user = SearchQuery(SearchQueryStrings.user, type: QueryType.user);
}

class SearchQueryStrings {
  static const String archived = 'archived';
  static const String assignee = 'assignee';
  static const String author = 'author';
  static const String authorName = 'author-name';
  static const String authorEmail = 'author-email';
  static const String authorDate = 'author-date';
  static const String base = 'base';
  static const String closed = 'closed';
  static const String commenter = 'commenter';
  static const String comments = 'comments';
  static const String committer = 'committer';
  static const String committerName = 'committer-name';
  static const String committerEmail = 'committer-email';
  static const String committerDate = 'committer-date';
  static const String created = 'created';
  static const String draft = 'draft';
  static const String extension = 'extension';
  static const String filename = 'filename';
  static const String followers = 'followers';
  static const String fork = 'fork';
  static const String forks = 'forks';
  static const String fullName = 'fullname';
  static const String goodFirstIssues = 'good-first-issues';
  static const String hash = 'hash';
  static const String head = 'head';
  static const String helpWantedIssues = 'help-wanted-issues';
  static const String iN = 'in';
  static const String interactions = 'interactions';
  static const String involves = 'involves';
  static const String iS = 'is';
  static const String label = 'label';
  static const String language = 'language';
  static const String license = 'license';
  static const String linked = 'linked';
  static const String location = 'location';
  static const String merge = 'merge';
  static const String merged = 'merged';
  static const String mentions = 'mentions';
  static const String milestone = 'milestone';
  static const String mirror = 'mirror';
  static const String no = 'no';
  static const String org = 'org';
  static const String parent = 'parent';
  static const String path = 'path';
  static const String project = 'project';
  static const String pushed = 'pushed';
  static const String reactions = 'reactions';
  static const String repo = 'repo';
  static const String repos = 'repos';
  static const String repositories = 'repositories';
  static const String review = 'review';
  static const String reviewedBy = 'reviewed-by';
  static const String reviewRequested = 'review-requested';
  static const String teamReviewRequested = 'team-review-requested';
  static const String sha = 'SHA';
  static const String size = 'size';
  static const String stars = 'stars';
  static const String state = 'state';
  static const String status = 'status';
  static const String team = 'team';
  static const String topic = 'topic';
  static const String topics = 'topics';
  static const String tree = 'tree';
  static const String type = 'type';
  static const String updated = 'updated';
  static const String user = 'user';
}

class SearchQuery {
  final String query;
  final String? description;
  Map<String, String>? options;
  final QueryType type;
  SearchQuery(this.query,
      {this.description, this.options, this.type = QueryType.string}) {
    if (type == QueryType.bool && options == null)
      options = {'true': '', 'false': ''};
  }
}

enum QueryType { string, date, number, user, bool }