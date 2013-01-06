# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/scponly/scponly-4.8-r4.ebuild,v 1.8 2012/12/15 16:54:19 ulm Exp $

EAPI="1"
inherit eutils multilib toolchain-funcs

DESCRIPTION="A tiny pseudoshell which only permits scp and sftp"
HOMEPAGE="http://www.sublimation.org/scponly/"
SRC_URI="mirror://sourceforge/scponly/${P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="+sftp scp winscp gftp rsync unison subversion wildcards quota passwd logging"

RDEPEND="sys-apps/sed
	net-misc/openssh
	quota? ( sys-fs/quota )
	rsync? ( net-misc/rsync )
	subversion? ( dev-vcs/subversion )"
DEPEND="${RDEPEND}"

myuser="scponly"
myhome="/home/${myuser}"
mysubdir="/pub"

pkg_setup() {
	if use unison; then
		if [ ! -e "${ROOT}usr/bin/unison" ]; then
			eerror
			eerror "please run 'eselect unison set <version>' first!"
			die "can't find /usr/bin/unison"
		fi
	fi

	if ! use subversion && ! use unison && ! use rsync && \
		! use sftp && ! use scp && ! use winscp; then
		eerror
		eerror "you have to enable at least one of the following use-flags:"
		eerror "sftp scp winscp rsync unison subversion"
		die "your build will quite useless without any compatibility mode"
	fi

	if use subversion || use unison || use rsync || use wildcards || use scp || use winscp; then
		ewarn
		ewarn "NOTE THE FOLLOWING SECURITY RISKS:"
		ewarn
		if use wildcards; then
			ewarn "-- by enabling wildcards, there is a slightly higher chance of an exploit"
		fi
		if use scp || use winscp; then
			ewarn "-- by enabling scp and/or winscp compatibility, more programs will need"
			ewarn "   to be installed in the chroot which increases the risk."
		fi
		if use subversion; then
			ewarn "-- CAUTION: by enabling subversion the user WILL BE ABLE TO EXECUTE"
			ewarn "   SCRIPTS OR PROGRAMS INDIRECTLY! svn and svnserve will try to execute"
			ewarn "   pre-commit, post-commit hooks, as well as a few others. These files"
			ewarn "   have specific filenames at specific locations relative to the svn"
			ewarn "   repository root. Thus, unless you are *very* careful about security,"
			ewarn "   the user WILL BE ABLE TO EXECUTE SCRIPTS OR PROGRAMS INDIRECTLY!"
			ewarn "   This can be prevented by a careful configuration."
		fi
		if use subversion || use unison || use rsync; then
			ewarn "-- The following programs use configuration files that might allow the"
			ewarn "   user to bypass security restrictions placed on command line arguments:"
			ewarn "   svn, svnserve, rsync, unison"
		fi
		ewarn
		ewarn "please read /usr/share/doc/${PF}/SECURITY* after install!"
		ewarn
		ebeep 5
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-rsync.patch"
	# bug #269242
	epatch "${FILESDIR}/${P}-gcc4.4.0.patch"
}

src_compile() {
	CFLAGS="${CFLAGS} ${LDFLAGS}" econf \
		--with-sftp-server="/usr/$(get_libdir)/misc/sftp-server" \
		--with-default-chdir="/" \
		--disable-restrictive-names \
		--enable-chrooted-binary \
		--enable-chroot-checkdir \
		$(use_enable winscp winscp-compat) \
		$(use_enable gftp gftp-compat) \
		$(use_enable scp scp-compat) \
		$(use_enable sftp sftp) \
		$(use_enable quota quota-compat) \
		$(use_enable passwd passwd-compat) \
		$(use_enable rsync rsync-compat) \
		$(use_enable unison unison-compat) \
		$(use_enable subversion svn-compat) \
		$(use_enable subversion svnserv-compat) \
		$(use_enable logging sftp-logging-compat) \
		$(use_enable wildcards wildcards) \
	|| die "econf failed"
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHOR BUILDING-JAILS.TXT CHANGELOG CONTRIB README SECURITY TODO

	# don't compress setup-script, so it is usable if necessary
	insinto /usr/share/doc/${PF}/chroot
	doins setup_chroot.sh config.h
}

pkg_postinst() {
	elog
	elog "You might want to run"
	elog "   emerge --config =${CATEGORY}/${PF}"
	elog "to setup the chroot. Otherwise you will have to setup chroot manually."
	elog
	elog "Please read the docs in /usr/share/doc/${PF} for more informations!"
	elog

	# two slashes ('//') are used by scponlyc to determine the chroot point.
	enewgroup "${myuser}"
	enewuser "${myuser}" -1 /usr/sbin/scponlyc "${myhome}//" "${myuser}"
}

pkg_config() {
	# pkg_postinst is based on ${S}/setup_chroot.sh.

	einfo "Collecting binaries and libraries..."

	# Binaries launched in sftp compat mode
	if built_with_use =${CATEGORY}/${PF} sftp; then
		BINARIES="/usr/$(get_libdir)/misc/sftp-server"
	fi

	# Binaries launched by vanilla- and WinSCP modes
	if built_with_use =${CATEGORY}/${PF} scp || \
		built_with_use =${CATEGORY}/${PF} winscp; then
		BINARIES="${BINARIES} /usr/bin/scp /bin/ls /bin/rm /bin/ln /bin/mv"
		BINARIES="${BINARIES} /bin/chmod /bin/chown /bin/chgrp /bin/mkdir /bin/rmdir"
	fi

	# Binaries launched in WinSCP compatibility mode
	if built_with_use =${CATEGORY}/${PF} winscp; then
		BINARIES="${BINARIES} /bin/pwd /bin/groups /usr/bin/id /bin/echo"
	fi

	# Rsync compatability mode
	if built_with_use =${CATEGORY}/${PF} rsync; then
		BINARIES="${BINARIES} /usr/bin/rsync"
	fi

	# Unison compatability mode
	if built_with_use =${CATEGORY}/${PF} unison; then
		BINARIES="${BINARIES} /usr/bin/unison"
	fi

	# subversion cli/svnserv compatibility
	if built_with_use =${CATEGORY}/${PF} subversion; then
		BINARIES="${BINARIES} /usr/bin/svn /usr/bin/svnserve"
	fi

	# passwd compatibility
	if built_with_use =${CATEGORY}/${PF} passwd; then
		BINARIES="${BINARIES} /bin/passwd"
	fi

	# quota compatibility
	if built_with_use =${CATEGORY}/${PF} quota; then
		BINARIES="${BINARIES} /usr/bin/quota"
	fi

	# build lib dependencies
	LIB_LIST=$(ldd ${BINARIES} | sed -n 's:.* => \(/[^ ]\+\).*:\1:p' | sort -u)

	# search and add ld*.so
	for LIB in /$(get_libdir)/ld.so /libexec/ld-elf.so /libexec/ld-elf.so.1 \
		/usr/libexec/ld.so /$(get_libdir)/ld-linux*.so.2 /usr/libexec/ld-elf.so.1; do
		[ -f "${LIB}" ] && LIB_LIST="${LIB_LIST} ${LIB}"
	done

	# search and add libnss_*.so
	for LIB in /$(get_libdir)/libnss_{compat,files}*.so.*; do
		[ -f "${LIB}" ] && LIB_LIST="${LIB_LIST} ${LIB}"
	done

	# create base dirs
	if [ ! -d "${myhome}" ]; then
		einfo "Creating ${myhome}"
		install -o0 -g0 -m0755 -d "${myhome}"
	else
		einfo "Setting owner for ${myhome}"
		chown 0:0 "${myhome}"
	fi

	if [ ! -d "${myhome}/etc" ]; then
		einfo "Creating ${myhome}/etc"
		install -o0 -g0 -m0755 -d "${myhome}/etc"
	fi

	if [ ! -d "${myhome}/$(get_libdir)" ]; then
		einfo "Creating ${myhome}/$(get_libdir)"
		install -o0 -g0 -m0755 -d "${myhome}/$(get_libdir)"
	fi

	if [ ! -e "${myhome}/lib" ]; then
		einfo "Creating ${myhome}/lib"
		ln -snf $(get_libdir) "${myhome}/lib"
	fi

	if [ ! -d "${myhome}/usr/$(get_libdir)" ]; then
		einfo "Creating ${myhome}/usr/$(get_libdir)"
		install -o0 -g0 -m0755 -d "${myhome}/usr/$(get_libdir)"
	fi

	if [ ! -e "${myhome}/usr/lib" ]; then
		einfo "Creating ${myhome}/usr/lib"
		ln -snf $(get_libdir) "${myhome}/usr/lib"
	fi

	if [ ! -d "${myhome}${mysubdir}" ]; then
		einfo "Creating ${myhome}${mysubdir} directory for uploading files"
		install -o${myuser} -g${myuser} -m0755 -d "${myhome}${mysubdir}"
	fi

	# create /dev/null (Bug 135505)
	if [ ! -e "${myhome}/dev/null" ]; then
		install -o0 -g0 -m0755 -d "${myhome}/dev"
		mknod -m0777 "${myhome}/dev/null" c 1 3
	fi

	# install binaries
	for BIN in ${BINARIES}; do
		einfo "Install ${BIN}"
		install -o0 -g0 -m0755 -d "${myhome}$(dirname ${BIN})"
		if [ "${BIN}" = "/bin/passwd" ]; then  # needs suid
			install -p -o0 -g0 -m04711 "${BIN}" "${myhome}/${BIN}"
		else
			install -p -o0 -g0 -m0755 "${BIN}" "${myhome}/${BIN}"
		fi
	done

	# install libs
	for LIB in ${LIB_LIST}; do
		einfo "Install ${LIB}"
		install -o0 -g0 -m0755 -d "${myhome}$(dirname ${LIB})"
		install -p -o0 -g0 -m0755 "${LIB}" "${myhome}/${LIB}"
	done

	# create ld.so.conf
	einfo "Creating /etc/ld.so.conf"
	for LIB in ${LIB_LIST}; do
		dirname ${LIB}
	done | sort -u | while read DIR; do
		if ! grep 2>/dev/null -q "^${DIR}$" "${myhome}/etc/ld.so.conf"; then
			echo "${DIR}" >> "${myhome}/etc/ld.so.conf"
		fi
	done
	ldconfig -r "${myhome}"

	# update shells
	einfo "Updating /etc/shells"
	grep 2>/dev/null -q "^/usr/bin/scponly$" /etc/shells \
		|| echo "/usr/bin/scponly" >> /etc/shells

	grep 2>/dev/null -q "^/usr/sbin/scponlyc$" /etc/shells \
		|| echo "/usr/sbin/scponlyc" >> /etc/shells

	# create /etc/passwd
	if [ ! -e "${myhome}/etc/passwd" ]; then
		(
			echo "root:x:0:0:root:/:/bin/sh"
			sed -n "s|^\(${myuser}:[^:]*:[^:]*:[^:]*:[^:]*:\).*|\1${mysubdir}:/bin/sh|p" /etc/passwd
		) > "${myhome}/etc/passwd"
	fi

	# create /etc/group
	if [ ! -e "${myhome}/etc/group" ]; then
		(
			echo "root:x:0:"
			sed -n "s|^\(${myuser}:[^:]*:[^:]*:\).*|\1|p" /etc/group
		) > "${myhome}/etc/group"
	fi
}
