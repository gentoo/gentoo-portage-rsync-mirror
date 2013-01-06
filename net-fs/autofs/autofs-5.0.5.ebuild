# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.0.5.ebuild,v 1.1 2010/06/09 08:27:00 pva Exp $

EAPI="2"

inherit eutils multilib autotools

PATCH_VER="1"
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI="mirror://kernel/linux/daemons/${PN}/v5/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="hesiod ldap sasl"

# currently, sasl code assumes the presence of kerberosV
DEPEND="hesiod? ( net-dns/hesiod )
	ldap? (
		>=net-nds/openldap-2.0
		sasl? (
			dev-libs/cyrus-sasl
			dev-libs/libxml2
			virtual/krb5
		)
	)"
RDEPEND="${DEPEND}"

src_prepare() {
	EPATCH_SUFFIX="patch" \
	epatch "${WORKDIR}"/patches

	# fixes bug #210762
	epatch "${FILESDIR}"/${PN}-5.0.3-heimdal.patch

	# Accumulated fixes for bugs
	#    #154797: Respect CC and CFLAGS
	#    #253412: Respect LDFLAGS
	#    #247969: Link order for --as-needed
	epatch "${FILESDIR}"/${P}-respect-user-flags-and-fix-asneeded.patch

	# do not include <nfs/nfs.h>, rather <linux/nfs.h>,
	# as the former is a lame header for the latter (bug #157968)
	sed 's@nfs/nfs.h@linux/nfs.h@' -i include/rpc_subs.h

	epatch "${FILESDIR}"/${P}-fix-building-without-sasl.patch

	eautoreconf
}

src_configure() {
	local myconf=""

	if use sasl && ! use ldap; then
		ewarn "USE=\"sasl\" adds SASL support to the LDAP module"
		ewarn "which will not be build. If SASL support should be"
		ewarn "available, please add \"ldap\" to the USE flags."
		myconf="--with-openldap=no --with-sasl=no"
		epause 5
	else
		myconf="$(use_with ldap openldap) $(use_with sasl)"
	fi

	econf \
		${myconf} \
		$(use_with hesiod) \
		--enable-ignore-busy
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
#	make DESTDIR="${D}" install_kernel || die "make install failed"
#	make DESTDIR="${D}" install_samples || die "make install failed"

	dodoc README* CHANGELOG CREDITS COPYRIGHT INSTALL || die "dodoc failed"

	# kernel patches
	docinto patches
	dodoc patches/${PN}4-2.6.??{,.?{,?}}-v5-update-????????.patch \
		|| die "Installing patches failed"

	newinitd "${FILESDIR}"/autofs5.rc1 autofs || die
}

pkg_postinst() {
	elog "Note: You might need to patch your kernel to use this"
	elog "version of ${PN}. Upstream kernel patches have been"
	elog "installed into \"/usr/share/doc/${P}/patches\"."
	elog "For further instructions, please refer to"
	elog "\"/usr/share/doc/${P}/README\"."
	elog ""
	elog "Note: If you plan on using autofs for automounting"
	elog "remote NFS mounts without having the NFS daemon running"
	elog "please add portmap or rpcbind to your default run-level."
}
