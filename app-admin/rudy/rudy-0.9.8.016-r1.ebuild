# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rudy/rudy-0.9.8.016-r1.ebuild,v 1.2 2014/05/26 05:49:52 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RESTRICT=test
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc examples/authorize.rb examples/gem-test.rb
	examples/solaris.rb examples/windows.rb"

RUBY_FAKEGEM_EXTRAINSTALL="Rudyfile"

inherit ruby-fakegem eutils versionator

DESCRIPTION="Not your grandparents' EC2 deployment tool"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

if [[ "$(get_version_component_range 4)" == "001" ]]; then
	MY_PV="$(get_version_component_range 1-3)"
else
	MY_PV="${PV}"
fi

SRC_URI="http://github.com/solutious/${PN}/tarball/v${MY_PV} -> ${PN}-git-${PV}.tgz"
RUBY_S="solutious-${PN}-*"

ruby_add_rdepend '
	>=dev-ruby/amazon-ec2-0.9.10
	>=dev-ruby/highline-1.5.1
	>=dev-ruby/aws-s3-0.6.1
	>=dev-ruby/storable-0.7.1
	>=dev-ruby/gibbler-0.7.7
	>=dev-ruby/sysinfo-0.7.3
	>=dev-ruby/caesars-0.7.4
	>=dev-ruby/drydock-0.6.9
	>=dev-ruby/annoy-0.5.6
	>=dev-ruby/attic-0.5.2
	>=dev-ruby/rye-0.9.2
	virtual/ruby-ssl'
