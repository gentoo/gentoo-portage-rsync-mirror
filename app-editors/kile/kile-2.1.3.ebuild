# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-2.1.3.ebuild,v 1.4 2012/12/10 17:04:49 kensington Exp $

EAPI=4

if [[ ${PV} != *9999* ]]; then
	KDE_DOC_DIRS="doc"
	KDE_HANDBOOK="optional"
	MY_P=${P/_beta/b}
	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
else
	EGIT_REPO_URI="http://anongit.kde.org/kile"
	GIT_ECLASS="git"
fi

inherit kde4-base ${GIT_ECLASS}

DESCRIPTION="A Latex Editor and TeX shell for KDE"
HOMEPAGE="http://kile.sourceforge.net/"

LICENSE="FDL-1.2 GPL-2"
KEYWORDS="amd64 ~ppc x86"
SLOT="4"
IUSE="debug +pdf +png"

DEPEND="
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdebase-data)
	|| (
		$(add_kdebase_dep okular 'pdf?,postscript')
		app-text/acroread
	)
	virtual/latex-base
	virtual/tex-base
	pdf? (
		app-text/dvipdfmx
		app-text/ghostscript-gpl
	)
	png? (
		app-text/dvipng
		media-gfx/imagemagick[png]
	)
"

S=${WORKDIR}/${MY_P}

DOCS=( kile-remote-control.txt )

src_prepare() {
	kde4-base_src_prepare

	# I know upstream wants to help us but it doesn't work..
	sed -e '/INSTALL( FILES AUTHORS/s/^/#DISABLED /' \
		-i CMakeLists.txt || die

	[[ ${PV} != *9999* ]] && { use handbook || rm -fr doc ; }
}
