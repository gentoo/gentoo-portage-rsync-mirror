# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-2.1.0.ebuild,v 1.1 2014/01/15 19:05:53 naota Exp $

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
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10"
