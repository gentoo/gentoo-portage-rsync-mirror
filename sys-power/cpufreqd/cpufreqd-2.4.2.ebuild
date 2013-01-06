# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/cpufreqd-2.4.2.ebuild,v 1.4 2010/07/19 19:18:34 josejx Exp $

EAPI="2"

inherit eutils

NVCLOCK_VERSION="0.8b"

DESCRIPTION="CPU Frequency Daemon"
HOMEPAGE="http://www.linux.it/~malattia/wiki/index.php/Cpufreqd"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		nvidia? ( http://www.linuxhardware.org/nvclock/nvclock${NVCLOCK_VERSION}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"

IUSE="acpi apm lm_sensors nforce2 nvidia pmu"
RDEPEND=">=sys-power/cpufrequtils-002
		sys-fs/sysfsutils
		lm_sensors? ( >sys-apps/lm_sensors-3 )"
DEPEND="sys-apps/sed
		${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-conf.d.patch

	if use nvidia; then
		cd "${WORKDIR}"/nvclock${NVCLOCK_VERSION}
		epatch "${FILESDIR}"/nvclock${NVCLOCK_VERSION}-fpic.patch
	fi
}

src_configure() {
	local config

	if use nvidia; then
		cd "${WORKDIR}"/nvclock${NVCLOCK_VERSION}
		econf \
			--disable-gtk \
			--disable-qt \
			--disable-nvcontrol \
			|| die "econf nvclock failed"
		emake -j1 || die "emake nvclock failed"
		config="--enable-nvclock=${WORKDIR}/nvclock${NVCLOCK_VERSION}"
	fi

	cd "${S}"
	econf \
		$(use_enable acpi) \
		$(use_enable apm) \
		$(use_enable lm_sensors sensors) \
		$(use_enable nforce2) \
		$(use_enable pmu) \
		${config} \
		|| die "econf failed"
}

src_compile() {
	if use nvidia; then
		cd "${WORKDIR}"/nvclock${NVCLOCK_VERSION}
	fi

	cd "${S}"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}"/usr/$(get_libdir)/*.la
	dodoc AUTHORS ChangeLog NEWS README TODO
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
}

pkg_postinst() {
	if [ -f "${ROOT}"/etc/conf.d/cpufreqd ] ; then
		ewarn "An old \"/etc/conf.d/cpufreqd\" file was found. It breaks"
		ewarn "the new init script! Please remove it."
		ewarn "# rm /etc/conf.d/cpufreqd"
	fi
}
