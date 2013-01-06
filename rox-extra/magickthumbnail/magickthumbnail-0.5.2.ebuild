# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/magickthumbnail/magickthumbnail-0.5.2.ebuild,v 1.4 2007/11/16 15:19:01 drac Exp $

ROX_LIB="2.0.0"
inherit rox eutils

MY_PN="MagickThumbnail"

DESCRIPTION="MagickThumbnail can generate thumbnails of many files many types in your ROX-Filer window."
HOMEPAGE="http://rox.maczewski.dyndns.org/"
SRC_URI="http://rox.maczewski.dyndns.org/prog/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="xcf"
KEYWORDS="amd64 x86"

RDEPEND="media-gfx/imagemagick
	xcf? ( media-gfx/gimp )"

APPNAME=${MY_PN}
S=${WORKDIR}
