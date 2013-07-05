# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-swing/ant-swing-1.9.1.ebuild,v 1.1 2013/07/05 14:25:24 tomwij Exp $

EAPI="5"

# No extra dependencies are needed.
ANT_TASK_DEPNAME=""

inherit ant-tasks

DESCRIPTION="Apache Ant's optional tasks for Swing."

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux \
	~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris \
	~x64-solaris ~x86-solaris"