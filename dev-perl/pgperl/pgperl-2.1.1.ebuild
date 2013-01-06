# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/pgperl/pgperl-2.1.1.ebuild,v 1.2 2010/06/17 18:29:03 patrick Exp $

inherit perl-module

DESCRIPTION="native Perl interface to PostgreSQL"
SRC_URI="mirror://postgresql/projects/gborg/pgperl/stable/Pg-${PV}.tar.gz"
HOMEPAGE="http://gborg.postgresql.org/project/pgperl/projdisplay.php"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

DEPEND="dev-db/postgresql-base
	dev-lang/perl"

S=${WORKDIR}/Pg-${PV}
src_compile() {
	export POSTGRES_LIB=`/usr/bin/pg_config --libdir`
	export POSTGRES_INCLUDE=`/usr/bin/pg_config --includedir`
	perl-module_src_compile
}
