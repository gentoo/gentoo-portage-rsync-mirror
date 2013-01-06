# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gconf/gst-plugins-gconf-0.10.30.ebuild,v 1.7 2012/12/02 16:12:48 eva Exp $

EAPI="1"
GCONF_DEBUG=no

inherit gnome2 gst-plugins-good gst-plugins10

DESCRIPTION="GStreamer plugin for wrapping GConf audio/video settings"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gconf gconftool"
