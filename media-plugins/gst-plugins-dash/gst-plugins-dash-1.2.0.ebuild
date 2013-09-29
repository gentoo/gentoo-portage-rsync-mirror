# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dash/gst-plugins-dash-1.2.0.ebuild,v 1.1 2013/09/29 17:55:11 eva Exp $

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
