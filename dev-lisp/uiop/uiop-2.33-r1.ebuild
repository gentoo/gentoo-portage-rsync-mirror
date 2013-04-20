# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/uiop/uiop-2.33-r1.ebuild,v 1.2 2013/04/20 16:55:21 grozin Exp $

EAPI=5
inherit eutils

DESCRIPTION="UIOP is a portability layer spun off ASDF3"
HOMEPAGE="http://common-lisp.net/project/asdf/"
SRC_URI="http://common-lisp.net/project/asdf/archives/asdf-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="~dev-lisp/asdf-${PV}"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /usr/share/common-lisp/source/${PN}
	doins -r contrib *.lisp ../version.lisp-expr uiop.asd asdf-driver.asd
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/${PN}/uiop.asd /usr/share/common-lisp/systems/uiop.asd
	dosym /usr/share/common-lisp/source/${PN}/asdf-driver.asd /usr/share/common-lisp/systems/asdf-driver.asd
}
