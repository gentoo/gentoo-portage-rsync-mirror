# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs-legacy/openafs-legacy-0.1.ebuild,v 1.6 2013/11/06 03:40:22 patrick Exp $

DESCRIPTION="Legacy path symlinks to access FHS-compliant OpenAFS installation"
HOMEPAGE="http://www.gentoo.org/ http://www.openafs.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/baselayout"
PDEPEND="net-fs/openafs"

# As a guide for these links, acinclude.m4 from the openafs package was
# used.  A README file exists as well, but at the time of writing, the
# afsbosserver-variable was inaccurately described.

src_compile() {
	ebegin "Nothing to compile"
	eend $?
}

src_install() {
	# some basenames for FHS paths
	sysconfdir=/etc
	libexecdir=/usr/libexec
	localstatedir=/var/lib
	sbindir=/usr/sbin

	# create parent directories for Transarc mode
	dodir /usr/{vice,afs}

	# viceetcdir
	viceetcdir=${sysconfdir}/openafs
	dosym ${viceetcdir} /usr/vice/etc

	# afssrvdir
	afssrvbindir=${libexecdir}/openafs
	dosym ${afssrvbindir} /usr/afs/bin

	# afsconfdir
	afsconfdir=${sysconfdir}/openafs/server
	dosym ${afsconfdir} /usr/afs/etc

	# afslocaldir
	afslocaldir=${localstatedir}/openafs
	dosym ${afslocaldir} /usr/afs/local

	# afsdbdir
	afsdbdir=${localstatedir}/openafs/db
	dosym ${afsdbdir} /usr/afs/db

	# afslogdir
	afslogdir=${localstatedir}/openafs/logs
	dosym ${afslogdir} /usr/afs/logs

	# afsbosconfig
	dodir ${afslocaldir}
	dosym ${viceetcdir}/BosConfig ${afslocaldir}/BosConfig

	# afsbosserver
	dodir ${afssrvbindir}
	dosym ${sbindir}/bosserver ${afssrvbindir}/bosserver
}

pkg_prerm() {
	ewarn "It is recommended to remove this package AFTER removing openafs"
	ewarn "This way there will be no dead links left lying around"
}
