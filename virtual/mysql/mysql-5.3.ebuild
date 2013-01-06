# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mysql/mysql-5.3.ebuild,v 1.1 2011/07/28 11:45:07 jmbsvicetto Exp $

EAPI="2"

DESCRIPTION="Virtual for MySQL client or database"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-macos ~x86-solaris"
IUSE="embedded minimal static"

DEPEND=""
RDEPEND="|| (
	=dev-db/mariadb-${PV}*[embedded=,minimal=,static=]
)"
