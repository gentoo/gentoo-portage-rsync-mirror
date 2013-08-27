# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.31.ebuild,v 1.12 2013/08/27 19:27:46 aballier Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer taglib based tag handler"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
