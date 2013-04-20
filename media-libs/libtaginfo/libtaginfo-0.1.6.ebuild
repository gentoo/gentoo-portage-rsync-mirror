# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtaginfo/libtaginfo-0.1.6.ebuild,v 1.1 2013/04/20 06:49:35 angelos Exp $

EAPI=4

DESCRIPTION="a library for reading media metadata"
HOMEPAGE="https://bitbucket.org/shuerhaaken/libtaginfo"
SRC_URI="https://bitbucket.org/shuerhaaken/${PN}/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/taglib
	!<media-sound/xnoise-0.2.16"
DEPEND="${DEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS README TODO )
