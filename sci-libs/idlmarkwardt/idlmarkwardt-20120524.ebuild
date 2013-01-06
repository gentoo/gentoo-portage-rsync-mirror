# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/idlmarkwardt/idlmarkwardt-20120524.ebuild,v 1.1 2012/07/03 22:26:19 bicatali Exp $

EAPI=4

DESCRIPTION="Craig Marqwardt IDL procedures (MPFIT, CMSVLIB, etc)"
HOMEPAGE="http://cow.physics.wisc.edu/~craigm/idl/idl.html"
SRC_URI="http://www.physics.wisc.edu/~craigm/idl/down/cmtotal.tar.gz -> ${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=""
RDEPEND=">=dev-lang/gdl-0.9.2-r1"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/gnudatalanguage/${PN}
	doins *.pro
	dodoc *README
}
