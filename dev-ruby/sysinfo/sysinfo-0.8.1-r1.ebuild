# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sysinfo/sysinfo-0.8.1-r1.ebuild,v 1.2 2014/04/24 16:52:44 mrueg Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP="sysinfo"

inherit ruby-fakegem

DESCRIPTION="All your system-independent info in one handy class"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND+=" !!dev-util/hxtools "

ruby_add_rdepend "dev-ruby/storable dev-ruby/drydock"
