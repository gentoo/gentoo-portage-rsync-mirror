# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-hls/gst-plugins-hls-1.2.3.ebuild,v 1.3 2014/03/09 12:07:37 pacho Exp $

EAPI="5"

inherit gst-plugins10 gst-plugins-bad

DESCRIPTION="HTTP live streaming plugin"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=net-libs/gnutls-2.11.3"
DEPEND="${RDEPEND}"

# FIXME: gsturidownloader does not have a .pc
#src_prepare() {
#	gst-plugins10_system_link \
#		gst-libs/gst/uridownloader:gsturidownloader
#}

src_compile() {
	cd "${S}"/gst-libs/gst/uridownloader
	emake

	cd "${S}"
	gst-plugins10_src_compile
}
