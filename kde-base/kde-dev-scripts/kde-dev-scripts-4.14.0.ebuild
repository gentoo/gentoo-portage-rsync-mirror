# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-dev-scripts/kde-dev-scripts-4.14.0.ebuild,v 1.1 2014/08/20 16:02:50 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE Development Scripts"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	!kde-base/kdesdk-scripts:4
	app-arch/advancecomp
	media-gfx/optipng
	dev-perl/XML-DOM
"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' CMakeLists.txt || die

	kde4-base_src_prepare
}
