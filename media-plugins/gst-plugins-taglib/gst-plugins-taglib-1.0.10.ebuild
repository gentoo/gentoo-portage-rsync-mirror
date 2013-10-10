# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-1.0.10.ebuild,v 1.2 2013/10/10 11:56:41 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer taglib based tag handler"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
