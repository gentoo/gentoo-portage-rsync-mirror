# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-duplicates/vdr-duplicates-0.0.4.ebuild,v 1.3 2012/07/01 07:53:17 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: show duplicated records"
HOMEPAGE="http://www.tolleri.net/vdr/"
SRC_URI="http://www.tolleri.net/vdr/plugins/${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	if has_version ">=media-video/vdr-1.7.28"; then
		sed -i "s:SetRecording(recording->FileName(), recording->Title:SetRecording(recording->FileName:" menu.c
	fi

	sed -e "s:include \$(VDRDIR)/Make.global:-include \$(VDRDIR)/Make.global:" -i Makefile
}
