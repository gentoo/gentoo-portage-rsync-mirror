# Base eclass for Java packages that needs to be OSGi compliant
#
# Copyright (c) 2007, Jean-Noël Rivasseau <elvanor@gmail.com>
# Copyright (c) 2007-2011, Gentoo Foundation
#
# Licensed under the GNU General Public License, v2
#
# $Header: /var/cvsroot/gentoo-x86/eclass/java-osgi.eclass,v 1.7 2011/12/27 17:55:12 fauli Exp $

# -----------------------------------------------------------------------------
# @eclass-begin
# @eclass-shortdesc Java OSGi eclass
# @eclass-maintainer java@gentoo.org
#
# This eclass provides functionality which is used by
# packages that need to be OSGi compliant. This means
# that the generated jars will have special headers in their manifests.
# Currently this is used only by Eclipse-3.3 - later
# we could extend this so that Gentoo Java system would be
# fully OSGi compliant.
#
# -----------------------------------------------------------------------------

inherit java-utils-2

# We define _OSGI_T so that it does not contain a slash at the end.
# According to Paludis guys, there is currently a proposal for EAPIs that
# would require all variables to end with a slash.

_OSGI_T="${T/%\//}"

# must get Diego to commit something like this to portability.eclass
_canonicalise() {
	if type -p realpath > /dev/null; then
		realpath "${@}"
	elif type -p readlink > /dev/null; then
		readlink -f "${@}"
	else
		# can't die, subshell
		eerror "No readlink nor realpath found, cannot canonicalise"
	fi
}

# -----------------------------------------------------------------------------
# @ebuild-function _java-osgi_plugin
#
# This is an internal function, not to be called directly.
#
# @example
#	_java-osgi_plugin "JSch"
#
# @param $1 - bundle name
#
# ------------------------------------------------------------------------------

_java-osgi_plugin() {
	# We hardcode Gentoo as the vendor name

	cat > "${_OSGI_T}/tmp_jar/plugin.properties" <<-EOF
	bundleName="${1}"
	vendorName="Gentoo"
	EOF
}

# -----------------------------------------------------------------------------
# @ebuild-function _java-osgi_makejar
#
# This is an internal function, not to be called directly.
#
# @example
#	_java-osgi_makejar "dist/${PN}.jar" "com.jcraft.jsch" "JSch" "com.jcraft.jsch, com.jcraft.jsch.jce;x-internal:=true"
#
# @param $1 - name of jar to repackage with OSGi
# @param $2 - bundle symbolic name
# @param $3 - bundle name
# @param $4 - export-package header
#
# ------------------------------------------------------------------------------

_java-osgi_makejar() {
	debug-print-function ${FUNCNAME} "$@"

	(( ${#} < 4 )) && die "Four arguments are needed for _java-osgi_makejar()"

	local absoluteJarPath="$(_canonicalise ${1})"
	local jarName="$(basename ${1})"

	mkdir "${_OSGI_T}/tmp_jar" || die "Unable to create directory ${_OSGI_T}/tmp_jar"
	[[ -d "${_OSGI_T}/osgi" ]] || mkdir "${_OSGI_T}/osgi" || die "Unable to create directory ${_OSGI_T}/osgi"

	cd "${_OSGI_T}/tmp_jar" && jar xf "${absoluteJarPath}" && cd - > /dev/null \
		 || die "Unable to uncompress correctly the original jar"

	cat > "${_OSGI_T}/tmp_jar/META-INF/MANIFEST.MF" <<-EOF
	Manifest-Version: 1.0
	Bundle-ManifestVersion: 2
	Bundle-Name: %bundleName
	Bundle-Vendor: %vendorName
	Bundle-Localization: plugin
	Bundle-SymbolicName: ${2}
	Bundle-Version: ${PV}
	Export-Package: ${4}
	EOF

	_java-osgi_plugin "${3}"

	jar cfm "${_OSGI_T}/osgi/${jarName}" "${_OSGI_T}/tmp_jar/META-INF/MANIFEST.MF" \
		-C "${_OSGI_T}/tmp_jar/" . > /dev/null || die "Unable to recreate the OSGi compliant jar"
	rm -rf "${_OSGI_T}/tmp_jar"
}

# -----------------------------------------------------------------------------
# @ebuild-function java-osgi_dojar
#
# Rewrites a jar, and produce an OSGi compliant jar from arguments given on the command line.
# The arguments given correspond to the minimal set of headers
# that must be present on a Manifest file of an OSGi package.
# If you need more headers, you should use the *-fromfile functions below,
# that create the Manifest from a file.
# It will call java-pkg_dojar at the end.
#
# @example
#	java-osgi_dojar "dist/${PN}.jar" "com.jcraft.jsch" "JSch" "com.jcraft.jsch, com.jcraft.jsch.jce;x-internal:=true"
#
# @param $1 - name of jar to repackage with OSGi
# @param $2 - bundle symbolic name
# @param $3 - bundle name
# @param $4 - export-package-header
#
# ------------------------------------------------------------------------------

java-osgi_dojar() {
	debug-print-function ${FUNCNAME} "$@"
	local jarName="$(basename ${1})"
	_java-osgi_makejar "$@"
	java-pkg_dojar "${_OSGI_T}/osgi/${jarName}"
}

# -----------------------------------------------------------------------------
# @ebuild-function java-osgi_newjar
#
# Rewrites a jar, and produce an OSGi compliant jar.
# The arguments given correspond to the minimal set of headers
# that must be present on a Manifest file of an OSGi package.
# If you need more headers, you should use the *-fromfile functions below,
# that create the Manifest from a file.
# It will call java-pkg_newjar at the end.
#
# @example
#	java-osgi_newjar "dist/${PN}.jar" "com.jcraft.jsch" "JSch" "com.jcraft.jsch, com.jcraft.jsch.jce;x-internal:=true"
#
# @param $1 - name of jar to repackage with OSGi
# @param $2 (optional) - name of the target jar. It will default to package name if not specified.
# @param $3 - bundle symbolic name
# @param $4 - bundle name
# @param $5 - export-package header
#
# ------------------------------------------------------------------------------

java-osgi_newjar() {
	debug-print-function ${FUNCNAME} "$@"
	local jarName="$(basename $1)"

	if (( ${#} > 4 )); then
		_java-osgi_makejar "${1}" "${3}" "${4}" "${5}"
		java-pkg_newjar "${_OSGI_T}/osgi/${jarName}" "${2}"
	else
		_java-osgi_makejar "$@"
		java-pkg_newjar "${_OSGI_T}/osgi/${jarName}"
	fi
}

# -----------------------------------------------------------------------------
# @ebuild-function _java-osgi_makejar-fromfile
#
# This is an internal function, not to be called directly.
#
# @example
#	_java-osgi_makejar-fromfile "dist/${PN}.jar" "${FILESDIR}/MANIFEST.MF" "JSch" 1
#
# @param $1 - name of jar to repackage with OSGi
# @param $2 - path to the Manifest file
# @param $3 - bundle name
# @param $4 - automatic version rewriting (0 or 1)
#
# ------------------------------------------------------------------------------

_java-osgi_makejar-fromfile() {
	debug-print-function ${FUNCNAME} "$@"

	((${#} < 4)) && die "Four arguments are needed for _java-osgi_makejar-fromfile()"

	local absoluteJarPath="$(_canonicalise ${1})"
	local jarName="$(basename ${1})"

	mkdir "${_OSGI_T}/tmp_jar" || die "Unable to create directory ${_OSGI_T}/tmp_jar"
	[[ -d "${_OSGI_T}/osgi" ]] || mkdir "${_OSGI_T}/osgi" || die "Unable to create directory ${_OSGI_T}/osgi"

	cd "${_OSGI_T}/tmp_jar" && jar xf "${absoluteJarPath}" && cd - > /dev/null \
		|| die "Unable to uncompress correctly the original jar"

	[[ -e "${2}" ]] || die "Manifest file ${2} not found"

	# We automatically change the version if automatic version rewriting is on

	if (( ${4} )); then
		cat "${2}" | sed "s/Bundle-Version:.*/Bundle-Version: ${PV}/" > \
			"${_OSGI_T}/tmp_jar/META-INF/MANIFEST.MF"
	else
		cat "${2}" > "${_OSGI_T}/tmp_jar/META-INF/MANIFEST.MF"
	fi

	_java-osgi_plugin "${3}"

	jar cfm "${_OSGI_T}/osgi/${jarName}" "${_OSGI_T}/tmp_jar/META-INF/MANIFEST.MF" \
		-C "${_OSGI_T}/tmp_jar/" . > /dev/null || die "Unable to recreate the OSGi compliant jar"
	rm -rf "${_OSGI_T}/tmp_jar"
}

# -----------------------------------------------------------------------------
# @ebuild-function java-osgi_newjar-fromfile()
#
# This function produces an OSGi compliant jar from a given manifest file.
# The Manifest Bundle-Version header will be replaced by the current version
# of the package, unless the --no-auto-version option is given.
# It will call java-pkg_newjar at the end.
#
# @example
#	java-osgi_newjar-fromfile "dist/${PN}.jar" "${FILESDIR}/MANIFEST.MF" "Standard Widget Toolkit for GTK 2.0"
#
# @param $opt
#	--no-auto-version - This option disables automatic rewriting of the
#		version in the Manifest file#
# @param $1 - name of jar to repackage with OSGi
# @param $2 (optional) - name of the target jar. It will default to package name if not specified.
# @param $3 - path to the Manifest file
# @param $4 - bundle name
#
# ------------------------------------------------------------------------------

java-osgi_newjar-fromfile() {
	debug-print-function ${FUNCNAME} "$@"
	local versionRewriting=1

	if [[ "${1}" == "--no-auto-version" ]]; then
		versionRewriting=0
		shift
	fi
	local jarName="$(basename ${1})"

	if (( ${#} > 3 )); then
		_java-osgi_makejar-fromfile "${1}" "${3}" "${4}" "${versionRewriting}"
		java-pkg_newjar "${_OSGI_T}/osgi/${jarName}" "${2}"
	else
		_java-osgi_makejar-fromfile "$@" "${versionRewriting}"
		java-pkg_newjar "${_OSGI_T}/osgi/${jarName}"
	fi
}

# -----------------------------------------------------------------------------
# @ebuild-function java-osgi_dojar-fromfile()
#
# This function produces an OSGi compliant jar from a given manifestfile.
# The Manifest Bundle-Version header will be replaced by the current version
# of the package, unless the --no-auto-version option is given.
# It will call java-pkg_dojar at the end.
#
# @example
#	java-osgi_dojar-fromfile "dist/${PN}.jar" "${FILESDIR}/MANIFEST.MF" "Standard Widget Toolkit for GTK 2.0"
#
# @param $opt
#	--no-auto-version - This option disables automatic rewriting of the
#		version in the Manifest file
# @param $1 - name of jar to repackage with OSGi
# @param $2 - path to the Manifest file
# @param $3 - bundle name
#
# ------------------------------------------------------------------------------

java-osgi_dojar-fromfile() {
	debug-print-function ${FUNCNAME} "$@"
	local versionRewriting=1

	if [[ "${1}" == "--no-auto-version" ]]; then
		versionRewriting=0
		shift
	fi
	local jarName="$(basename ${1})"

	_java-osgi_makejar-fromfile "$@" "${versionRewriting}"
	java-pkg_dojar "${_OSGI_T}/osgi/${jarName}"
}
