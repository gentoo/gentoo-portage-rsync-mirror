# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.5.0-r1.ebuild,v 1.6 2012/12/08 12:35:25 ago Exp $

EAPI=4

DESCRIPTION="Virtual for JRE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.5"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| (
		virtual/jdk:1.5
		dev-java/sun-jre-bin:1.5
		dev-java/jamvm:0
	)"
