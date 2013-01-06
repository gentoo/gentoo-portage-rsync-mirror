# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/audioread/audioread-0.6.ebuild,v 1.4 2012/05/30 12:42:07 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Module for decoding audio files using whichever backend is available"
HOMEPAGE="http://pypi.python.org/pypi/audioread"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( dev-python/gst-python dev-python/pymad media-video/ffmpeg )"

pkg_postinst() {
		elog "You might need to enable additional USE flags in backends to"
		elog "decode some types of audio files. Priority of backends:"
		elog "   * gstreamer"
		elog "   * mad"
		elog "   * ffmpeg"
}
