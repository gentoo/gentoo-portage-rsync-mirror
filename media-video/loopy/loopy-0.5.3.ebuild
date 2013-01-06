# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/loopy/loopy-0.5.3.ebuild,v 1.1 2011/04/28 13:24:51 scarabeus Exp $

EAPI=4
KDE_LINGUAS="cs de hu pt_BR"
inherit kde4-base

MY_P=${P/-/_}

DESCRIPTION="A simple video player for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Loopy?content=120880"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/120880-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${MY_P}

DOCS=( THEMING )
