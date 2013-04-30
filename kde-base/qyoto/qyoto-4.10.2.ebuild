# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qyoto/qyoto-4.10.2.ebuild,v 1.3 2013/04/30 09:40:12 ago Exp $

EAPI=5

KDE_REQUIRED="never"
inherit kde4-base mono

DESCRIPTION="C# bindings for Qt"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +phonon qscintilla webkit"

DEPEND="
	dev-lang/mono
	$(add_kdebase_dep smokeqt 'opengl,phonon?,qscintilla?,webkit?')
"
RDEPEND="${DEPEND}"

# Split from kdebindings-csharp in 4.7
add_blocker kdebindings-csharp

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_disable qscintilla QScintilla)
		$(cmake-utils_use_disable webkit QtWebKit)
	)
	kde4-base_src_configure
}
