# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-toolkit/nvidia-cuda-toolkit-4.2.9-r3.ebuild,v 1.3 2013/11/26 09:28:44 jlec Exp $

EAPI=5

inherit cuda unpacker versionator

MYD=$(get_version_component_range 1)_$(get_version_component_range 2)
DISTRO=ubuntu11.04

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="http://developer.nvidia.com/cuda"
CURI="http://developer.download.nvidia.com/compute/cuda/${MYD}/rel/toolkit"
SRC_URI="
	amd64? ( ${CURI}/cudatoolkit_${PV}_linux_64_${DISTRO}.run )
	x86? ( ${CURI}/cudatoolkit_${PV}_linux_32_${DISTRO}.run )"

SLOT="0/${PV}"
LICENSE="NVIDIA-CUDA"
KEYWORDS="-* ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debugger doc eclipse profiler"

DEPEND=""
RDEPEND="${DEPEND}
	|| (
		sys-devel/gcc:4.4
		sys-devel/gcc:4.5
		sys-devel/gcc:4.6
		)
	!<=x11-drivers/nvidia-drivers-270.41
	debugger? ( sys-libs/libtermcap-compat )
	profiler? ( >=virtual/jre-1.6 )"

S="${WORKDIR}"

QA_PREBUILT="opt/cuda/*"

pkg_setup() {
	# We don't like to run cuda_pkg_setup as it depends on us
	:
}

src_prepare() {
	local cuda_supported_gcc dfiles files

	cuda_supported_gcc="4.4 4.5 4.6"

	sed \
		-e "s:CUDA_SUPPORTED_GCC:${cuda_supported_gcc}:g" \
		"${FILESDIR}"/cuda-config.in > "${T}"/cuda-config || die

	dfiles="install-linux.pl libnvvp/jre run_files"
	use amd64 && dfiles+=" cuda-installer.pl"
	for files in ${dfiles}; do
		if [[ -e ${files} ]]; then
			find ${files} -delete || die
		fi
	done
}

src_install() {
	local i
	local remove="doc"
	local cudadir=/opt/cuda
	local ecudadir="${EPREFIX}"${cudadir}

	if use doc; then
		dodoc doc/*{txt,pdf}
		dohtml -r doc/{*.html,html}
	fi

	use debugger || remove+=" bin/cuda-gdb extras/Debugger"

	if use profiler; then
		# hack found in install-linux.pl
		cat > bin/nvvp <<- EOF
			#!${EPREFIX}bin/sh
			LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:${ecudadir}/lib:${ecudadir}/lib64 \
				UBUNTU_MENUPROXY=0 LIBOVERLAY_SCROLLBAR=0 ${ecudadir}/libnvvp/nvvp
		EOF
		chmod a+x bin/nvvp
	else
		use eclipse || remove+=" libnvvp"
		remove+=" extras/CUPTI"
	fi

	for i in ${remove}; do
		if [[ -e ${i} ]]; then
			find ${i} -delete || die
		fi
	done

	dodir ${cudadir}
	mv * "${ED}"${cudadir}

	cat > "${T}"/99cuda <<- EOF
		PATH=${ecudadir}/bin:${ecudadir}/libnvvp
		ROOTPATH=${ecudadir}/bin
		LDPATH=${ecudadir}/lib$(use amd64 && echo "64:${ecudadir}/lib")
	EOF
	doenvd "${T}"/99cuda

	dobin "${T}"/cuda-config
}

pkg_postinst_check() {
	local a b
	a="$(version_sort $(cuda-config -s))"; a=( $a )
	# greatest supported version
	b=${a[${#a[@]}-1]}

	# if gcc and if not gcc-version is at least greatesst supported
	if [[ $(tc-getCC) == *gcc* ]] && \
		! version_is_at_least $(gcc-version) ${b}; then
			echo
			ewarn "gcc >= ${b} will not work with CUDA"
			ewarn "Make sure you set an earlier version of gcc with gcc-config"
			ewarn "or append --compiler-bindir= pointing to a gcc bindir like"
			ewarn "--compiler-bindir=${EPREFIX}/usr/*pc-linux-gnu/gcc-bin/gcc${b}"
			ewarn "to the nvcc compiler flags"
			echo
	fi
}

pkg_postinst() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		pkg_postinst_check
	fi
}
