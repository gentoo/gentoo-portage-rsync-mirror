# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-1.2.6.ebuild,v 1.2 2014/03/10 16:16:20 mrueg Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

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
