# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opus/opus-1.1.ebuild,v 1.2 2014/06/19 13:07:49 mgorny Exp $

EAPI=5

if [[ ${PV} == *9999 ]] ; then
	SCM="git-2"
	EGIT_REPO_URI="git://git.opus-codec.org/opus.git"
	AUTOTOOLS_AUTORECONF="1"
fi

inherit autotools-multilib ${SCM}

MY_P=${P/_/-}
DESCRIPTION="Open versatile codec designed for interactive speech and audio transmission over the internet"
HOMEPAGE="http://opus-codec.org/"
SRC_URI="http://downloads.xiph.org/releases/opus/${P}.tar.gz"
if [[ ${PV} == *9999 ]] ; then
	SRC_URI=""
elif [[ ${PV%_p*} != ${PV} ]] ; then # Gentoo snapshot
	SRC_URI="http://dev.gentoo.org/~lu_zero/${PN}/${P}.tar.xz"
else # Official release
	SRC_URI="http://downloads.xiph.org/releases/${PN}/${MY_P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE="custom-modes doc static-libs"

DEPEND="doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}

src_configure() {
	local myeconfargs=(
		$(use_enable custom-modes)
		$(use_enable doc)
	)
	autotools-multilib_src_configure
}
