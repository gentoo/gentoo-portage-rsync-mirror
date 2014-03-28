# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.8.0.ebuild,v 1.1 2014/03/28 15:08:57 tomwij Exp $

EAPI="5"

DESCRIPTION="Virtual for Java Runtime Environment (JRE)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.8"

# TODO: Temporarily dropped ~sparc-solaris and ~x86-solaris as oracle-jre-bin
#       no longer provides them. Also temporarily dropped ~ia64.
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc64-solaris ~x64-solaris"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.8.0*
		=dev-java/oracle-jre-bin-1.8.0*
	)"
DEPEND=""
