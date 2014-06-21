# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-2.2.0.ebuild,v 1.2 2014/06/21 06:51:39 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
DEPEND="${DEPEND}
	dev-libs/gobject-introspection
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
