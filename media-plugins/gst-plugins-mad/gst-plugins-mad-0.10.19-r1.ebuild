# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-0.10.19-r1.ebuild,v 1.11 2014/10/11 13:19:47 maekke Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-ugly
inherit gstreamer

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/libmad-0.15.1b-r8[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
