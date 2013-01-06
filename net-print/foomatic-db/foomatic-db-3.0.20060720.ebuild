# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-3.0.20060720.ebuild,v 1.2 2011/05/06 16:11:32 jlec Exp $

inherit versionator

MY_P=${PN}-$(replace_version_separator 2 '-')
DESCRIPTION="Printer information files for foomatic-db-engine to generate ppds"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${MY_P}.tar.gz
	http://linuxprinting.org/download/foomatic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="net-print/foomatic-db-engine"

S="${WORKDIR}/${PN}-$(get_version_component_range 3 ${PV})"

src_compile() {
	econf \
		--disable-gzip-ppds \
		--disable-ppds-to-cups
	# ppd files do not belong to this package
	rm -r db/source/PPD
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README TODO USAGE
}
