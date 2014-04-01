# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/katepart/katepart-4.12.4.ebuild,v 1.1 2014/04/01 18:09:34 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kate"
KMMODULE="part"
inherit kde4-meta

DESCRIPTION="KDE Editor KPart"
HOMEPAGE+=" http://kate-editor.org/about-katepart/"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# bug 392993

KMEXTRA="
	addons/ktexteditor
"

PATCHES=( "${FILESDIR}/${PN}-4.12.3-crash-fix.patch" )

src_configure() {
	local mycmakeargs=(
		"-DKDE4_BUILD_TESTS=OFF"
	)

	kde4-meta_src_configure
}
