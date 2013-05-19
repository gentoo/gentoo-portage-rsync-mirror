# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/asdf/asdf-3.0.1.ebuild,v 1.1 2013/05/19 05:13:01 grozin Exp $

EAPI=5
inherit eutils

DESCRIPTION="ASDF is Another System Definition Facility for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/asdf/"
SRC_URI="http://common-lisp.net/project/${PN}/archives/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

SLOT="0/${PVR}"

DEPEND="!dev-lisp/cl-${PN}
		!dev-lisp/asdf-binary-locations
		!dev-lisp/gentoo-init
		!<dev-lisp/asdf-2.33-r3
		doc? ( <sys-apps/texinfo-5.0 virtual/texi2dvi )"
RDEPEND=""
PDEPEND="~dev-lisp/uiop-${PV}"

S="${WORKDIR}"

src_compile() {
	make
	use doc && make doc
}

src_install() {
	insinto /usr/share/common-lisp/source/${PN}
	doins -r build version.lisp-expr
	dodoc README TODO
	dohtml doc/*.{html,css,ico,png}
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/${PN}.pdf
	fi

	insinto /etc/common-lisp
	doins "${FILESDIR}"/gentoo-init.lisp "${FILESDIR}"/source-registry.conf
}
