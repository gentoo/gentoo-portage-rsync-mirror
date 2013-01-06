# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/regina-rexx/regina-rexx-3.6.ebuild,v 1.4 2012/12/15 18:13:37 jer Exp $

inherit toolchain-funcs

WANT_AUTOCONF="2.1"

DESCRIPTION="Portable Rexx interpreter"
HOMEPAGE="http://regina-rexx.sourceforge.net"
SRC_URI="mirror://sourceforge/regina-rexx/Regina-REXX-${PV}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/Regina-REXX-${PV}

src_compile() {
	econf
	sed -i \
		-e 's|-$(INSTALL) -m 755 -c ./rxstack.init.d $(STARTUPDIR)/rxstack||' \
		-e "s|/usr/share/regina|${D}/usr/share/regina|" \
		Makefile || die
	emake CC=$(tc-getCC) -j1 || die "make problem"
}

src_install() {
	einstall datadir="${D}"/usr/share/regina || die
	rm -rf "${D}"/etc/rc.d

	doinitd "${FILESDIR}"/rxstack

	dodoc BUGS HACKERS.txt README.Unix README_SAFE TODO

	# Fix Shebang line in example scripts
	sed -e 's:/var/tmp/portage/dev-lang/regina-rexx-3.3/image::' \
		-i "${D}"/usr/share/regina/regina/*.rexx || die
}

pkg_postinst() {
	elog "You may want to run"
	elog
	elog "\trc-update add rxstack default"
	elog
	elog "to enable Rexx queues (optional)."
}
