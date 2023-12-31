\name{mapping-and-querying}
\alias{mapUniProt}
\alias{queryUniProt}
\alias{allToKeys}
\alias{allFromKeys}
\alias{returnFields}
\alias{cols}
\title{
Mapping identifiers with the UniProt API
}
\description{
These functions are the main workhorses for mapping identifiers from one
database to another. They make use of the latest UniProt API (seen at
\url{https://www.uniprot.org/help/api}).
}
\usage{
mapUniProt(
    from = "UniProtKB_AC-ID",
    to = "UniRef90",
    columns = character(0L),
    query,
    verbose = FALSE,
    debug = FALSE,
    paginate = TRUE,
    pageSize = 500L
)
queryUniProt(
    query = character(0L),
    fields = c("accession", "id"),
    collapse = " OR ",
    n = Inf,
    pageSize = 25L
)
allToKeys(fromName = "UniProtKB_AC-ID")
allFromKeys()
returnFields()
}
\arguments{
  \item{from}{
    character(1)
    The identifier type to map from, by default "UniProtKB_AC-ID", short for
    UniProt accession identifiers.
    See a list of all 'from' type identifiers with \code{allFromKeys}.
  }
  \item{to}{
    character(1)
    The target mapping identifier, by default "UniRef90". It can be any one of
    those returned by \code{allToKeys} from the appropriate \code{fromName}
    argument.
  }
  \item{columns,fields}{
    character() Additional information to be retreived from UniProt service.
    See a full list of possible input return fields at
    \url{https://www.uniprot.org/help/return_fields}. Example fields include,
    "accession", "id", "gene_names", "xref_pdb", "xref_hgnc", "sequence", etc.
  }
  \item{query}{
    character() or named list() Typically, a string that would indicate the target
    accession identifiers but can also be a named list based on the available
    query fields. See \url{https://www.uniprot.org/help/query-fields}
    for a list of query fields. The typical query might only include a
    character vector of UniProt accession identifiers, e.g.,
    \code{c("A0A0C5B5G6", "A0A1B0GTW7", "A0JNW5", "A0JP26", "A0PK11", "A1A4S6")}
  }
  \item{collapse}{
    character(1) A string indicating either \code{" OR "} or \code{" AND "}
    for combining \code{query} clauses.
  }
  \item{n}{
    numeric(1) Maximum number of rows to return
  }
  \item{fromName}{
    character(1) A \code{from} key to use as the basis of mapping to other
    keys, by default, \code{"UniProtKB_AC-ID"}.
  }
  \item{verbose}{
    logical(1) Whether the operations should provide verbose updates (default
    \code{FALSE}).
  }
  \item{debug}{
    logical(1) Whether to display the URL API endpoints, for advanced debugging
    (default \code{FALSE})
  }
  \item{paginate}{
    logical(1) Whether to use the pagination API (i.e., "results" vs "stream")
    in the request responses. For performance, it is set to \code{TRUE} by
    default.
  }
  \item{pageSize}{
    integer(1) number of records per page. It corresponds to the \code{size}
    parameter in the API request.
  }
}
\details{
  Note that \code{mapUniProt} is used internally by the \code{select} method
  but made available for API queries with finer control. Provide values from
  the \code{name} column in \code{returnFields} as the \code{columns} input
  in either \code{mapUniProt} or \code{select} method.

  When using \code{from='Gene_Name'}, you may restrict the search results
  to a specific organism by including e.g., \code{taxId=9606} in the query
  as a named list element. See examples below.
}
\value{
  \itemize{
    \item{mapUniProt}{A data.frame of returned results}
    \item{allToKeys}{A sorted character vector of possible "To" keytypes based
      on the given "From" type}
    \item{allFromKeys}{A sorted character vector of possible "From" keytypes}
    \item{returnFields}{A data.frame of entries for the columns input in
      \code{mapUniprot}; see 'name' column}
  }
}
\author{
  Marcel Ramos
}
\examples{
mapUniProt(
    from="UniProtKB_AC-ID",
    to='RefSeq_Protein',
    query=c('P13368','Q9UM73','P97793','Q17192')
)

mapUniProt(
    from='GeneID', to='UniProtKB', query=c('1','2','3','9','10')
)

mapUniProt(
    from = "UniProtKB_AC-ID",
    to = "UniProtKB",
    columns = c("accession", "id"),
    query = list(organism_id = 10090, ids = c('Q7TPG8', 'P63318'))
)

## restrict 'from = Gene_Name' result to taxId 9606
mapUniProt(
    from = "Gene_Name",
    to = "UniProtKB-Swiss-Prot",
    columns = c("accession", "id"),
    query = list(taxId = 9606, ids = 'TP53')
)

mapUniProt(
    from = "UniProtKB_AC-ID", to = "UniProtKB",
    query = c("P31946", "P62258"),
    columns = c("accession", "id", "xref_pdb", "xref_hgnc", "sequence")
)

queryUniProt(
    query = c("accession:A5YMT3", "organism_id:9606"),
    fields = c("accession", "id", "reviewed"),
    collapse = " AND "
)

allToKeys(fromName = "UniRef100")

head(allFromKeys())

head(returnFields())
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
