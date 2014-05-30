# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.5.0-r1.ebuild,v 1.2 2014/05/30 11:20:17 tomwij Exp $

EAPI="5"

DESCRIPTION="Virtual for Java Development Kit (JDK)"
SLOT="1.5"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"

RDEPEND="|| (
		=dev-java/apple-jdk-bin-1.5.0*
		dev-java/gcj-jdk
	)"
