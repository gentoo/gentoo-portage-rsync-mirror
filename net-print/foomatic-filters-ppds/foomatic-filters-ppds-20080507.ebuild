# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-filters-ppds/foomatic-filters-ppds-20080507.ebuild,v 1.2 2013/12/27 22:39:12 dilfridge Exp $

inherit eutils

DESCRIPTION="linuxprinting.org PPD files for non-postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.gz
	http://linuxprinting.org/download/foomatic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="
	|| ( >=net-print/cups-filters-1.0.43 net-print/foomatic-filters )
"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix a symlink collision, see bug #172341
	sed -i -e '/ln -s \$prefix\/share\/ppd \$destdir\$ppddir\/foomatic-ppds/d' "${S}"/install
	# Fix building if /bin/sh isn't bash.  Bug #176799
	epatch "${FILESDIR}/${PN}-20070501-remove-bashisms.patch"
}

src_compile() {
	rm -f $(find . -name "*gimp-print*")
	rm -f $(find . -name "*hpijs*")
	# conflicts with foomatic-filters
	rm -f bin/{foomatic-gswrapper,foomatic-rip}
	rm -f share/man/man1/{foomatic-gswrapper,foomatic-rip}.1
}

src_install() {
	./install -d "${D}" -p /usr -z || die "ppds install failed"
	dodoc README
}
