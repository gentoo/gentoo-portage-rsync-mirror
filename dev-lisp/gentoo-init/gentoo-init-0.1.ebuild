# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gentoo-init/gentoo-init-0.1.ebuild,v 1.11 2012/04/07 10:29:17 neurogeek Exp $

EAPI="3"

DESCRIPTION="Simple ASDF-BINARY-LOCATIONS configuration for Gentoo Common Lisp ports."
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/common-lisp/guide.xml"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

S=${WORKDIR}

DEPEND="dev-lisp/asdf-binary-locations"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc
	doins "${FILESDIR}"/gentoo-init.lisp
}
