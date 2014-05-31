# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dash/gst-plugins-dash-1.2.4.ebuild,v 1.1 2014/05/31 14:23:54 pacho Exp $

EAPI="5"

inherit gst-plugins10 gst-plugins-bad

DESCRIPTION="MPEG-DASH plugin"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxml2"
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
