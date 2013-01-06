# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qyoto/qyoto-4.9.4.ebuild,v 1.1 2012/12/05 16:57:49 alexxy Exp $

EAPI=4

KDE_REQUIRED="never"
inherit kde4-base mono

DESCRIPTION="C# bindings for Qt"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
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
