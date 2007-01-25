# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="https://faracvs.cs.uni-magdeburg.de/svn/christsc/darbackup/darbackup/branches/0.7.13-svn392"

DESCRIPTION="a wrapper script for creating backups using dar"
HOMEPAGE="https://faracvs.cs.uni-magdeburg.de/projects/christsc-darbackup/"
SRC_URI=""
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=app-backup/dar-2.2.6
        || ( dev-util/bdelta dev-util/xdelta )
        net-misc/openssh"
DEPEND=">=app-shells/bash-3.0"

src_install() {
	dobin darbackup
	doman darbackup.1
}

pkg_setup() {
	enewgroup backup
	if ! built_with_use dar dar32 && ! built_with_use dar dar64; then
		die 'You must have dar32 or dar64 useflags for dar enabled.'
	fi
}
