# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subdownloader/subdownloader-2.0.14-r1.ebuild,v 1.1 2012/06/28 13:36:44 tampakrap Exp $

EAPI=4

inherit python eutils

DESCRIPTION="GUI application for automatic downloading/uploading of subtitles for videofiles"
HOMEPAGE="http://www.subdownloader.net/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/PyQt4
	dev-python/kaa-metadata"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/${PN}
	doins -r cli FileManagement gui languages locale modules run.py
	fperms 755 /usr/share/${PN}/run.py
	dosym /usr/share/${PN}/run.py /usr/bin/${PN}
	doman ${PN}.1
	dodoc README ChangeLog
	doicon gui/images/${PN}.png
	domenu ${PN}.desktop
}
