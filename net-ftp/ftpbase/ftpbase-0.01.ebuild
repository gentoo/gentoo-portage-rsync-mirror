# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpbase/ftpbase-0.01.ebuild,v 1.2 2013/03/03 09:00:33 vapier Exp $

inherit eutils pam user

DESCRIPTION="FTP layout package"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="pam"

DEPEND="pam? ( || ( virtual/pam sys-libs/pam ) )
	!<net-ftp/proftpd-1.2.10-r6
	!<net-ftp/pure-ftpd-1.0.20-r2
	!<net-ftp/vsftpd-2.0.3-r1"

S=${WORKDIR}

check_collision() {
	[[ ! -e $1 ]] && return 0

	[[ $(head -n 1 "$1") == $(head -n 1 "$2") ]] && return 0

	eerror "   $1 exists and was not provided by ${P}"
	return 1
}

pkg_setup() {
	ebegin "Checking for possible file collisions..."

	local collide=false
	check_collision "${ROOT}etc/ftpusers" "${FILESDIR}/ftpusers" || collide=true

	if use pam ; then
		check_collision "${ROOT}etc/pam.d/ftp" "${FILESDIR}/ftp-pamd" || collide=true
	fi

	if ${collide} ; then
		eerror
		eerror "Those files listed above have to be removed in order to"
		eerror "install this version of ftpbase."
		eerror
		eerror "If you edited them, remember to backup and when restoring make"
		eerror " sure the first line in each file is:"
		eerror "$(head -n 1 "${FILESDIR}/ftpusers")"
		eend 1
		die "Can't be installed, files will collide"
	fi

	eend 0

	# Check if home exists
	local exists=false
	[[ -d "${ROOT}home/ftp" ]] && exists=true

	# Add our default ftp user
	enewgroup ftp 21
	enewuser ftp 21 -1 /home/ftp ftp

	# If home did not exist and does now then we created it in the enewuser
	# command. Now we have to change it's permissions to something sane.
	if [[ ${exists} == "false" && -d "${ROOT}home/ftp" ]] ; then
		chown root:ftp "${ROOT}"home/ftp
	fi
}

src_install() {
	# The ftpusers file is a list of people who are NOT allowed
	# to use the ftp service.
	insinto /etc
	doins "${FILESDIR}/ftpusers" || die

	# Ideally we would create the home directory here with a dodir.
	# But we cannot until bug #9849 is solved - so we kludge in pkg_postinst()

	if use pam ; then
		if has_version "<sys-libs/pam-0.78" ; then
			newpamd "${FILESDIR}/ftp-pamd" ftp
		else
			newpamd "${FILESDIR}/ftp-pamd-include" ftp
		fi
	fi
}
