# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.9.4.ebuild,v 1.2 2012/12/25 11:21:19 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
KMMODULE="scripts"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE SDK Scripts"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	app-arch/advancecomp
	media-gfx/optipng
"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}
