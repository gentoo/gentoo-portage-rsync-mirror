# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/publicfile/publicfile-0.52-r4.ebuild,v 1.6 2015/03/21 21:04:15 jlec Exp $

EAPI=5

inherit eutils toolchain-funcs user

DESCRIPTION="publish files through FTP and HTTP"
HOMEPAGE="http://cr.yp.to/publicfile.html"
SRC_URI="
	http://cr.yp.to/publicfile/${P}.tar.gz
	http://www.ohse.de/uwe/patches/${P}-filetype-diff
	http://www.publicfile.org/ftp-ls-patch"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="selinux vanilla"

RDEPEND="
	virtual/daemontools
	>=sys-apps/ucspi-tcp-0.83
	selinux? ( sec-policy/selinux-publicfile )
	!net-ftp/netkit-ftpd"

RESTRICT="mirror bindist test"

src_prepare() {
	# verbose build log
	epatch "${FILESDIR}"/${P}-build.patch

	# filetypes in env using daemontools
	use vanilla || epatch "${DISTDIR}"/${P}-filetype-diff

	# "normal" ftp listing
	use vanilla || epatch "${DISTDIR}"/ftp-ls-patch

	# fix for glibc-2.3.2 errno issue
	sed -i -e 's|extern int errno;|#include <errno.h>|' error.h || die

	# fix file collision
	sed -i configure.c \
		-e 's|/bin/httpd|/bin/publicfile-httpd|' \
		-e 's|/bin/ftpd|/bin/publicfile-ftpd|' \
		|| die "sed file collision failed"
}

src_configure() {
	tc-export AR RANLIB
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr" > conf-home
}

src_install() {
	newbin ftpd publicfile-ftpd httpd publicfile-httpd configure publicfile-conf
	dodoc CHANGES README TODO
}

pkg_preinst() {
	# nofiles should be GID=200 to match djbdns, qmail, fnord, publicfile
	nofiles_gid=$(getent group nofiles |cut -d: -f3)
	if [[ -n $nofiles_gid ]] && [[ $nofiles_gid -ne 200 ]]; then
		ewarn "Your nofiles group has the wrong GID due to an "
		ewarn "ebuild bug. Fixing now..."
		groupmod -g 200 nofiles
		usermod -g nofiles ftp
		usermod -g nofiles ftplog
	fi
	enewgroup nofiles 200
	enewuser ftp -1 -1 /home/public nofiles
	enewuser ftplog -1 -1 /home/public nofiles
}

pkg_postinst() {
	if [ ! -d /home/public/httpd ]; then
		einfo "Setting up server root in /home/public"
		if [ -d /home/public ]; then
			backupdir=public.old-$(date +%s)
			einfo "Serverroot exists... backing up to ${backupdir}"
			mv /home/public /home/${backupdir}
		fi
		/usr/bin/publicfile-conf ftp ftplog /home/public `hostname`
	fi
	echo
	einfo "publichtml-httpd and public-html ftpd are serving out"
	einfo "of /home/public. Remember to start the servers with:"
	einfo "  ln -s /home/public/public-httpd /home/public/public-ftpd /service"
	echo
}
