# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.6.5-r1.ebuild,v 1.1 2013/08/30 14:52:17 axs Exp $

EAPI="4"

inherit flag-o-matic eutils autotools multilib toolchain-funcs versionator pam

MY_PV=$(delete_version_separator '_')
MY_P="${PN}-${MY_PV}"
PVER="1"
DESCRIPTION="The OpenAFS distributed file system"
HOMEPAGE="http://www.openafs.org/"
# We always d/l the doc tarball as man pages are not USE=doc material
SRC_URI="http://openafs.org/dl/openafs/${MY_PV}/${MY_P}-src.tar.bz2
	http://openafs.org/dl/openafs/${MY_PV}/${MY_P}-doc.tar.bz2
	mirror://gentoo/${P}-patches-${PVER}.tar.bz2"

LICENSE="IBM BSD openafs-krb5-a APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc kerberos pam"

RDEPEND="~net-fs/openafs-kernel-${PV}
	sys-libs/ncurses
	pam? ( sys-libs/pam )
	kerberos? ( virtual/krb5 )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	EPATCH_SUFFIX="patch" \
	epatch "${WORKDIR}"/gentoo/patches

	# packaging is f-ed up, so we can't run eautoreconf
	# run autotools commands based on what is listed in regen.sh
	eaclocal -I src/cf
	eautoconf
	eautoconf -o configure-libafs configure-libafs.ac
	eautoheader
	einfo "Deleting autom4te.cache directory"
	rm -rf autom4te.cache
}

src_configure() {
	# cannot use "use_with" macro, as --without-krb5-config crashes the econf
	local myconf=""
	if use kerberos; then
		myconf="--with-krb5-conf=$(type -p krb5-config)"
	fi

	AFS_SYSKVERS=26 \
	XCFLAGS="${CFLAGS}" \
	econf \
		$(use_enable pam) \
		--enable-supergroups \
		--disable-kernel-module \
		--disable-strip-binaries \
		${myconf}
}

src_compile() {
	emake all_nolibafs
}

src_install() {
	local CONFDIR=${WORKDIR}/gentoo/configs
	local SCRIPTDIR=${WORKDIR}/gentoo/scripts

	emake DESTDIR="${ED}" install_nolibafs

	insinto /etc/openafs
	doins src/afsd/CellServDB
	echo "/afs:/var/cache/openafs:200000" > "${ED}"/etc/openafs/cacheinfo
	echo "openafs.org" > "${ED}"/etc/openafs/ThisCell

	# pam_afs and pam_afs.krb have been installed in irregular locations, fix
	if use pam ; then
		dopammod "${ED}"/usr/$(get_libdir)/pam_afs*
	fi
	rm -f "${ED}"/usr/$(get_libdir)/pam_afs* || die

	# remove kdump stuff provided by kexec-tools #222455
	rm -rf "${ED}"/usr/sbin/kdump*

	# avoid collision with mit_krb5's version of kpasswd
	mv "${ED}"/usr/bin/kpasswd{,_afs} || die
	mv "${ED}"/usr/share/man/man1/kpasswd{,_afs}.1 || die

	# move lwp stuff around #200674 #330061
	mv "${ED}"/usr/include/{lwp,lock,timer}.h "${ED}"/usr/include/afs/ || die
	mv "${ED}"/usr/$(get_libdir)/liblwp* "${ED}"/usr/$(get_libdir)/afs/ || die
	# update paths to the relocated lwp headers
	sed -ri \
		-e '/^#include <(lwp|lock|timer).h>/s:<([^>]*)>:<afs/\1>:' \
		"${ED}"/usr/include/*.h \
		"${ED}"/usr/include/*/*.h \
		|| die

	# minimal documentation
	use pam && doman src/pam/pam_afs.5
	dodoc "${CONFDIR}"/README src/afsd/CellServDB

	# documentation package
	if use doc ; then
		find doc/{arch,examples,pdf,protocol,txt}/ -type f -exec dodoc {} +
		dohtml -A xml -r doc/{html,xml}/*
	fi

	# Gentoo related scripts
	newinitd "${SCRIPTDIR}"/openafs-client openafs-client || die
	newconfd "${CONFDIR}"/openafs-client openafs-client || die
	newinitd "${SCRIPTDIR}"/openafs-server openafs-server || die
	newconfd "${CONFDIR}"/openafs-server openafs-server || die

	# used directories: client
	keepdir /etc/openafs
	keepdir /var/cache/openafs

	# used directories: server
	keepdir /etc/openafs/server
	diropts -m0700
	keepdir /var/lib/openafs
	keepdir /var/lib/openafs/db
	diropts -m0755
	keepdir /var/lib/openafs/logs

	# link logfiles to /var/log
	dosym ../lib/openafs/logs /var/log/openafs
}

pkg_preinst() {
	## Somewhat intelligently install default configuration files
	## (when they are not present)
	local x
	for x in cacheinfo CellServDB ThisCell ; do
		if [ -e "${EROOT}"/etc/openafs/${x} ] ; then
			cp "${EROOT}"/etc/openafs/${x} "${ED}"/etc/openafs/
		fi
	done
}

pkg_postinst() {
	elog "This installation should work out of the box (at least the"
	elog "client part doing global afs-cell browsing, unless you had"
	elog "a previous and different configuration).  If you want to"
	elog "set up your own cell or modify the standard config,"
	elog "please have a look at the Gentoo OpenAFS documentation"
	elog "(warning: it is not yet up to date wrt the new file locations)"
	elog
	elog "The documentation can be found at:"
	elog "  http://www.gentoo.org/doc/en/openafs.xml"
}
