# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ladspa/gst-plugins-ladspa-0.10.22.ebuild,v 1.6 2012/12/25 17:51:23 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/ladspa-sdk-1.12-r2
	>=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-libs/gst-plugins-bad-${PV}:0.10" # uses signalprocessor helper library
DEPEND="${RDEPEND}
	>=media-libs/gst-plugins-bad-${PV}:0.10"

src_unpack() {
	unpack ${A}

	gst-plugins10_find_plugin_dir
	# signalprocessor has no .pc
	sed -e "s:\$(top_builddir)/gst-libs/gst/signalprocessor/.*\.la:-lgstsignalprocessor-${SLOT}:" \
		-i Makefile.am Makefile.in || die
}
