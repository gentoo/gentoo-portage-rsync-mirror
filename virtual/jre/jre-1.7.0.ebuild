# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.7.0.ebuild,v 1.5 2012/10/30 20:34:31 grobian Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.7"
KEYWORDS="~amd64 ~ia64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.7.0*
		=dev-java/oracle-jre-bin-1.7.0*
	)"
DEPEND=""
