# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/livestreamer/livestreamer-1.7.2.ebuild,v 1.3 2014/02/22 08:07:59 ago Exp $

EAPI="5"

DESCRIPTION="CLI tool that pipes video streams from services like twitch.tv into a video player"
HOMEPAGE="https://github.com/chrippa/livestreamer"
SRC_URI="https://github.com/chrippa/livestreamer/archive/v${PV}.tar.gz -> ${P}.tar.gz"

PYTHON_COMPAT=( python{2_7,3_2} )
inherit distutils-r1

KEYWORDS="amd64 ~mips x86"
LICENSE="Apache-2.0 BSD-2 MIT-with-advertising"
SLOT="0"

RDEPEND="dev-python/pycrypto
	>=dev-python/requests-1.0
	>media-video/rtmpdump-2.4"
DEPEND="${RDEPEND}
	dev-python/setuptools"
