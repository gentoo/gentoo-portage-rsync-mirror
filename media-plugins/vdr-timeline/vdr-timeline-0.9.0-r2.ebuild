# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-timeline/vdr-timeline-0.9.0-r2.ebuild,v 1.5 2006/11/16 13:44:57 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder Timeline PlugIn"
HOMEPAGE="http://www.js-home.org/vdr/timeline/"
SRC_URI="http://www.js-home.org:80/vdr/timeline/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0"

src_unpack() {
	vdr-plugin_src_unpack

	has_version ">=media-video/vdr-1.3.7" && has_version "<=media-video/vdr-1.3.22" && \
	epatch ${FILESDIR}/vdr-1.3.18-${P}.diff

	has_version ">=media-video/vdr-1.3.23" && has_version "<=media-video/vdr-1.3.36" && \
	epatch ${FILESDIR}/vdr-1.3.23-${P}.diff

	has_version ">=media-video/vdr-1.3.32" && epatch ${FILESDIR}/vdr-1.3.32-${P}.diff

	has_version ">=media-video/vdr-1.3.37" && epatch ${FILESDIR}/vdr-1.3.37-${P}.diff

	epatch ${FILESDIR}/vdr-timeline-fix-crash-no-timer.diff
}
