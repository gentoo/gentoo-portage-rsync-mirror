# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/pgperl/pgperl-2.0.2.ebuild,v 1.16 2014/07/22 10:58:53 zlogene Exp $

EAPI=5

inherit perl-module

DESCRIPTION="native Perl interface to PostgreSQL"
SRC_URI="ftp://gborg.postgresql.org/pub/pgperl/stable/${P}.tar.gz"
HOMEPAGE="http://gborg.postgresql.org/project/pgperl/projdisplay.php"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

DEPEND="dev-db/postgresql-server
	dev-lang/perl"

S=${WORKDIR}/Pg-${PV}
src_compile() {
	export POSTGRES_HOME=/var/lib/postgresql
	perl-module_src_compile
}
